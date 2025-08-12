Return-Path: <linux-kernel+bounces-764592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F951B224D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268E61A2895A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D55F2ED17C;
	Tue, 12 Aug 2025 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pOu3TFT8"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3895A2D59E8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995577; cv=none; b=aVbjmb3Mnf3/Xe6bMZkb+e2nAdTR8J7Qtix+KI5sm2ZqPTt8qF6ZNqRnjrr0X//NAU0ogYzVtsEj8ZuOcvfe6fSi3xkWMgQ+xNt+00jq2bxdguRK3H4vCbaT+W2MYLzYG/8izIG0kPgBty2X63M1mmw7DFLKylWOgcPJ+uXKQaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995577; c=relaxed/simple;
	bh=mXlOmXXy918rASXvtZIVPDqyYAZmrU42vh530MenKMo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UWoDY/XJBTReOLq5Xn3Kb12jXwRddKlO7baJmUiZUFbAJvLNtFhGGJyx2efXi9Knj0JobwnIOGxnPx79doOZ77xRCP6dxyTFukGnsREG3gf8H1VkB5mAyb3Wc9albbNyRYKUciTppFxr6R07LrBoByyj5hwqHLlKU2OATzJ5z2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pOu3TFT8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=bxIeDsMrcQcfMnP4YcLQ9R8Rqxr0Wt8Vdq6pJjThJM0=; b=pOu3TFT8+SEFzc/rO/Yb2BXsuw
	9kGtXmO0Fvc54BSwh3osSrCnDw3BTjogy5UwzfX+bPVLHczod7nruq5hSI9qHyKO9FySIaOQcAAaG
	xdtuDA9kRjSqpFoqlYxezQ8bp+X4ILjadZi4s9/ufYS7ZAihbJDrH1XS9UtR6iM+Hm4fjyDsvdiLQ
	Q4d9c7NVOFbrVBXIyu4bMaRa5P4QUIENMCYiIYn2hvEmac4CvYr8NzO0f5C7JNAwrilcq7ssxACGl
	Ru3B4Yso3xlu/lL59zbg7as9Iud5BWIZwmctjWdNpgBKy2+k82EwJ9BUGyb2BEZl3m2KD5v8CXO9n
	mUNx8Rzw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmWB-0000000FmkB-24E3;
	Tue, 12 Aug 2025 10:46:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id BF171302EA6; Tue, 12 Aug 2025 12:46:09 +0200 (CEST)
Message-ID: <20250812104019.838047976@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 12 Aug 2025 12:39:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 torvalds@linuxfoundation.org,
 mingo@kernel.org,
 namhyung@kernel.org,
 acme@redhat.com,
 kees@kernel.org
Subject: [PATCH v3 13/15] perf: Use scoped_guard() for mmap_mutex in perf_mmap()
References: <20250812103858.234850285@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Mostly just re-indent noise.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7143,27 +7143,23 @@ static int perf_mmap(struct file *file,
 	if (vma_size != PAGE_SIZE * nr_pages)
 		return -EINVAL;
 
-	mutex_lock(&event->mmap_mutex);
-	ret = -EINVAL;
+	scoped_guard (mutex, &event->mmap_mutex) {
+		/*
+		 * This relies on __pmu_detach_event() taking mmap_mutex after marking
+		 * the event REVOKED. Either we observe the state, or __pmu_detach_event()
+		 * will detach the rb created here.
+		 */
+		if (event->state <= PERF_EVENT_STATE_REVOKED) {
+			ret = -ENODEV;
+			break;
+		}
 
-	/*
-	 * This relies on __pmu_detach_event() taking mmap_mutex after marking
-	 * the event REVOKED. Either we observe the state, or __pmu_detach_event()
-	 * will detach the rb created here.
-	 */
-	if (event->state <= PERF_EVENT_STATE_REVOKED) {
-		ret = -ENODEV;
-		goto unlock;
+		if (vma->vm_pgoff == 0)
+			ret = perf_mmap_rb(vma, event, nr_pages);
+		else
+			ret = perf_mmap_aux(vma, event, nr_pages);
 	}
 
-	if (vma->vm_pgoff == 0)
-		ret = perf_mmap_rb(vma, event, nr_pages);
-	else
-		ret = perf_mmap_aux(vma, event, nr_pages);
-
-unlock:
-	mutex_unlock(&event->mmap_mutex);
-
 	if (ret)
 		return ret;
 



