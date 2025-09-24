Return-Path: <linux-kernel+bounces-830100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6571B98BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708AE2A3827
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539EE286D49;
	Wed, 24 Sep 2025 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a4u98U6E"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBF92820A0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701020; cv=none; b=VFxxg1qjNoFoxRaRMDSRlwsDFq2LSJXKXTLBkfMQj2/rGn9Y5P2aBTTRutsQ1XcyCoNB2q8ivxkXTLpNQBHlwGcyaqgkdGlP+VOBur/5n22rLmSku4lFjj5u7V+Ae2utgj1b46irBYdVtSB6P9gWRuVy6OVP7VT7gNJvi9MciHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701020; c=relaxed/simple;
	bh=i6Vw4Ih1S80eP+vqt699mlMmyf72rKFWx2F8Pn2W3RI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=m91cL+DELmbITcWrwQiagfj8+K1m7r01LBaKbPHeobSUiN0jlUtAfrxA+hQmwi7YRhFDve8lVleJG0L1NPZKfvykRk4SeT8M8O8VHuPvBEPaerhHjoDQE7dwEFlvyCJnPXz+40hGfT6TN6WAYvq9FklIIBltuTog4gaz1DeFTsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a4u98U6E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=UH3hyurzcrwCnH6P3LZU6oD5I44GKx2Vs+NW8JK3KmI=; b=a4u98U6E7gmPa3Q8dpVoiJG8Tt
	Oj3qYFZySWEyyULbvu4sCe/slBlVpePEy8wniowlZtyu93l8jIPlEyvnKRudzKC1SHR9UkYcj19a0
	gGHXmNnN3lCeBOfAw0jXnDu+xhivREuSGxxwYT/r9dPTFEFoXoct8CbSp6NqP04TDs1hFpzUkZfrs
	uYMtBukQbgMmDWSqZIn41zwje0URhJjG6vJ0WZdU+FVGalWE8EteMrt8To7gZTiI+zTrHuIJRoMly
	OariTEBZFsb7dc1zlo+B5Ph5x8ty0gJETiKMOPsM2KnGyrgEL4FEHkU7a6sAYQs6FRvYy4tLChVo5
	co0OFmQw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KTO-0000000BeCo-03ZM;
	Wed, 24 Sep 2025 08:03:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 111E1302DA9; Wed, 24 Sep 2025 10:03:33 +0200 (CEST)
Message-ID: <20250924080118.777916262@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 09:59:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 rostedt@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 04/12] unwind: Simplify unwind_reset_info()
References: <20250924075948.579302904@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Invert the condition of the first if and make it an early exit to
reduce an indent level for the rest fo the function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/unwind_deferred.h |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -45,22 +45,22 @@ void unwind_deferred_task_exit(struct ta
 static __always_inline void unwind_reset_info(void)
 {
 	struct unwind_task_info *info = &current->unwind_info;
-	unsigned long bits;
+	unsigned long bits = info->unwind_mask;
 
 	/* Was there any unwinding? */
-	if (unlikely(info->unwind_mask)) {
-		bits = info->unwind_mask;
-		do {
-			/* Is a task_work going to run again before going back */
-			if (bits & UNWIND_PENDING)
-				return;
-		} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
-		current->unwind_info.id.id = 0;
+	if (likely(!bits))
+		return;
 
-		if (unlikely(info->cache)) {
-			info->cache->nr_entries = 0;
-			info->cache->unwind_completed = 0;
-		}
+	do {
+		/* Is a task_work going to run again before going back */
+		if (bits & UNWIND_PENDING)
+			return;
+	} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
+	current->unwind_info.id.id = 0;
+
+	if (unlikely(info->cache)) {
+		info->cache->nr_entries = 0;
+		info->cache->unwind_completed = 0;
 	}
 }
 



