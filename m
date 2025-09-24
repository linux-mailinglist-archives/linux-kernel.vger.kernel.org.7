Return-Path: <linux-kernel+bounces-830106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD04B98BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89E118938EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C26D2882A8;
	Wed, 24 Sep 2025 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K0g9fXm+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776E52820C7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701021; cv=none; b=mc6XZX6psAWjSG0itvWtIWj0DkSNBe3HD2NR5IcUmmfnq9hAEsSqDNObfmA1wEpbIYd4MCDs65qRYQU0OsMLyCzL/1OaHfkbQQxolO96xVKV3ZPGSqKkShsft5TyZKlBJA/nt3BBoFEV7YgeZcE3ifTPjOV2vOy3kFpovNptWok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701021; c=relaxed/simple;
	bh=62ustbkopVhBdcLoC7hwC9z9bDpnZ7IWCPTGeIvCKP4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=tCDITKBGRTPimll1G4iezmdl6qRWdnh+5irwwNOlUvfS+U7KRrJAaut6o8hrl3m5o3KLutadc/GVXwEpYNU1EKHd8zPbtflyE3Pz/3iKpPguH9NRLaZZHGWATEhxbMZ/hIqVq6Ou2XSr/TTxsIbkAv1v7jiPdcf1GXbnyn4Lm8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K0g9fXm+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Ua0dxI0J08PM8zvyZk5eD4nV7fTxFbZ9tXP0wSe2am4=; b=K0g9fXm+B6oxbUqjmInTle4xCS
	0g2H7OEfBblBht8ZaLNwDTF5CwJZ9lCes3KvN4LipdYHTqs0swtcl3oHfKB2TOFERkRHtu67VnHpm
	tzozFMcYkjn/b2nS96AM188ggak4t+eVrO3akJB5q2Ku6Nz5SX17pPnS+zLys3DZfha0oECRO5bu6
	0F72BuvN1kx6XoyJO/oWx799a2cM1N4ODlXsoLtbIhLj5wZDe2dKgQe3xg5MAei6cYFbhFZh/kutb
	C9+uhen+crC4GxOsrQq7IiTFJBZFoWW9ALMM7kApr18pBI8o3id2tlNEzYBwfLzO1FHUWFuywzgO4
	mgtE0JzQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KTO-0000000BeCi-00JQ;
	Wed, 24 Sep 2025 08:03:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0117A30050D; Wed, 24 Sep 2025 10:03:32 +0200 (CEST)
Message-ID: <20250924080118.425949403@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 09:59:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 rostedt@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 01/12] task_work: Fix NMI race condition
References: <20250924075948.579302904@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

  __schedule()
  // disable irqs
      <NMI>
	  task_work_add(current, work, TWA_NMI_CURRENT);
      </NMI>
  // current = next;
  // enable irqs
      <IRQ>
	  task_work_set_notify_irq()
	  test_and_set_tsk_thread_flag(current,
                                       TIF_NOTIFY_RESUME); // wrong task!
      </IRQ>
  // original task skips task work on its next return to user (or exit!)

Fixes: 466e4d801cd4 ("task_work: Add TWA_NMI_CURRENT as an additional notify mode.")
Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/task_work.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -9,7 +9,12 @@ static struct callback_head work_exited;
 #ifdef CONFIG_IRQ_WORK
 static void task_work_set_notify_irq(struct irq_work *entry)
 {
-	test_and_set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+	/*
+	 * no-op IPI
+	 *
+	 * TWA_NMI_CURRENT will already have set the TIF flag, all
+	 * this interrupt does it tickle the return-to-user path.
+	 */
 }
 static DEFINE_PER_CPU(struct irq_work, irq_work_NMI_resume) =
 	IRQ_WORK_INIT_HARD(task_work_set_notify_irq);
@@ -86,6 +91,7 @@ int task_work_add(struct task_struct *ta
 		break;
 #ifdef CONFIG_IRQ_WORK
 	case TWA_NMI_CURRENT:
+		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
 		irq_work_queue(this_cpu_ptr(&irq_work_NMI_resume));
 		break;
 #endif



