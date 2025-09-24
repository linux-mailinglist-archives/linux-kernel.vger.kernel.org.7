Return-Path: <linux-kernel+bounces-830102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1F4B98BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65204C03E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75556286D77;
	Wed, 24 Sep 2025 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y0xnflNW"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FE12820C6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701020; cv=none; b=bL6YbLiPcTZfsCqXy+s6O1UcmXBCedM30ZC5WsDjXVUndnKa1kWevesDFK1lgUhCi7hgH/TqXNquDm9F1rc9DOcHkI2fLjsc1otcFr1Uaz2gpa8jq21IBGo5aXW9j0c8GmiHDHyN6e46GQATcaFEUAC/5jwQCFCJTGwY9v6P+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701020; c=relaxed/simple;
	bh=YigqAcV+w42hf+VWmVcy7vItFroM6sD/V4ecsb9NhFo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DP/pU0UebNlZ4NziJt1mGQKHq1sqNJDz3HlhyAHf5YM5Ghw6RbeGA9SiIJu8SLuXAW8mWDTAjr+53dKU4P+2uLR5hTMxTwY/KA2ORpE7fdZFihIQvv6pJdJZJLQ4e7Kc+bnUFpggefgAaitBR3Y4CDRjSL36kKLR5p+2pIB8Nqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y0xnflNW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=+BxQ8ZbeEQeKLpVX1+kLc7lt/Zs1GYs12EyToR1lv80=; b=Y0xnflNWrSb3yFmTemScuCxx3s
	t8mmMEq8X6g9NQPuwaBc1x8jdrWFW2TL4dMxOe5pAS5aXP0M3jN4MdmH9O8nfSrFdD435A310rhaj
	bFOZn9aCHony82Vl7S3CmUjHgI6sa6Ajp9xszCEvixRK7GJ0HhgZKTStnlH0NzgHjlyOtJGjMohyS
	yZ9+Yo1AoFyMIom00x7EBCXrxRVCYyi+myuUYPySmBgguaEJCSsmqGKr9gUmEU23ZTY8Aoc8+8Dnl
	TOzYYL8IS+ka/r7+G5AaJGxfZqKmpJvLp7f0k6kMjpcvIzXeqQOAlOtj4sXxtQsOb5FqqW6MCNSiZ
	PcZA6cKw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KTO-0000000BeEK-2TIX;
	Wed, 24 Sep 2025 08:03:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 29E0A303007; Wed, 24 Sep 2025 10:03:33 +0200 (CEST)
Message-ID: <20250924080119.497867836@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 09:59:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 rostedt@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 10/12] unwind: Simplify unwind_user_next_fp() alignment check
References: <20250924075948.579302904@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/unwind/user.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -19,7 +19,6 @@ static int unwind_user_next_fp(struct un
 {
 	const struct unwind_user_frame *frame = &fp_frame;
 	unsigned long cfa, fp, ra;
-	unsigned int shift;
 
 	if (frame->use_fp) {
 		if (state->fp < state->sp)
@@ -37,8 +36,7 @@ static int unwind_user_next_fp(struct un
 		return -EINVAL;
 
 	/* Make sure that the address is word aligned */
-	shift = sizeof(long) == 4 ? 2 : 3;
-	if (cfa & ((1 << shift) - 1))
+	if (cfa & (sizeof(long) - 1))
 		return -EINVAL;
 
 	/* Find the Return Address (RA) */



