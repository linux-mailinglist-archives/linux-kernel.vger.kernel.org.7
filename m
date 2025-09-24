Return-Path: <linux-kernel+bounces-830098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79B2B98BA9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8046A2A30CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ADF283CA3;
	Wed, 24 Sep 2025 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RaiB78UR"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE543D544
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701018; cv=none; b=JhfLfF1R2r3iJx76TfMLYkgX7G9N8NbArHb1VrGJi2rwDK5uMy9zzxaVpTKLmOl1Vqc1Zrng5lz3+6m+pIvkRwY9w/LWvcCa8JfHLMk6SnL2ybU/Yxqq1pLRNil7YLf92PJptu8ypND2/QrPIQSPlkqQzomFU/XJCc2JLDzXImc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701018; c=relaxed/simple;
	bh=Ov2zrF6uYs5dWAepTYDchyC1M2a1bUwpg6VC+Crlgco=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nDdD09a64iGVpTYvpGfU2L1Ha/1Zx2GPPMOoLaVO6Cvsgyg4l6zu1mOOFcnLFGLFg6uRx7HWM9wnArME0mRfjLJtwr1CSaR76dND1Wrn0tq3OPwQ/20ex1xMsYdWRs6am1S3O+/YPG/SFgp3cIXo8ctW08LPSB9SPEcHLtwUOQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RaiB78UR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=hbxVc5Zp1LGC/PA+spY5cB8SwZ/Fdxj7XTfNHEYwPWc=; b=RaiB78URPr5B8Du+qz0ajvJREW
	RpzTgUhn8IMrMAe8ajLTC+JFQn1rkXtqYnAiIc3uIbLYVXUs/B5O+8lWRajIWE+Er+gnd9yb5TqUV
	xuZgfS6Q/RBYdjU4JBByQl/jXeuWj8syBpraNsYEoS5MxRzyzXmC7fmU5rlnUPhtj2mjVknt8mf6x
	SSGE2yxrjrO2wMUNhCxcYxzHnJE+cYA1XysqS7jlF8bDpOWEaT/fnO1Q6gpXpCAH+XWx5jR74GQPZ
	BnAeq1bDGZryqBv1AeaDIU8bi8AFnFHUZ45NaszArh1aS60UrVnyicwncWwwFWFf8SKcPcTrnOvF0
	0Ae7eDAw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KTO-00000008iB7-2RzJ;
	Wed, 24 Sep 2025 08:03:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 181F1302E5F; Wed, 24 Sep 2025 10:03:33 +0200 (CEST)
Message-ID: <20250924080119.005422353@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 09:59:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 rostedt@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 06/12] unwind: Fix unwind_deferred_request() vs NMI
References: <20250924075948.579302904@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

task_work_add(RWA_RESUME) isn't NMI-safe, use TWA_NMI_CURRENT when
used from NMI context.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/unwind/deferred.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -231,6 +231,7 @@ void unwind_deferred_task_exit(struct ta
 int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info = &current->unwind_info;
+	int twa_mode = TWA_RESUME;
 	unsigned long old, bits;
 	unsigned long bit;
 	int ret;
@@ -246,8 +247,11 @@ int unwind_deferred_request(struct unwin
 	 * Trigger a warning to make it obvious that an architecture
 	 * is using this in NMI when it should not be.
 	 */
-	if (WARN_ON_ONCE(!CAN_USE_IN_NMI && in_nmi()))
-		return -EINVAL;
+	if (in_nmi()) {
+		if (WARN_ON_ONCE(!CAN_USE_IN_NMI))
+			return -EINVAL;
+		twa_mode = TWA_NMI_CURRENT;
+	}
 
 	/* Do not allow cancelled works to request again */
 	bit = READ_ONCE(work->bit);
@@ -285,7 +289,7 @@ int unwind_deferred_request(struct unwin
 	}
 
 	/* The work has been claimed, now schedule it. */
-	ret = task_work_add(current, &info->work, TWA_RESUME);
+	ret = task_work_add(current, &info->work, twa_mode);
 
 	if (WARN_ON_ONCE(ret))
 		WRITE_ONCE(info->unwind_mask, 0);



