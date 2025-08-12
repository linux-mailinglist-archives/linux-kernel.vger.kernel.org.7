Return-Path: <linux-kernel+bounces-764582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E939B224D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD101A28164
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F9E2ECD03;
	Tue, 12 Aug 2025 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eqgRjKvx"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1F32EBB97
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995575; cv=none; b=s0+UdgJCtFnI2GPs0AGMcDxfocoIe96ml4JG3U/653FUy9FQw4mUmk/dAlSw8b0u6KaNqFxlRZVGM/5C8BcKtQMd8mbl1xGZHKzGVAWc1vYNEHnB1D3I7vb7HVurkt2k91QlNZp2FCNNjfd5HVpxq01hdNvPDbj/5kiVJI0tsaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995575; c=relaxed/simple;
	bh=OdvD/3vzW42we+neywbF2Wl66RwgbZPElQB80Jczvys=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ezps5TAIahHBwomJY/mzzzL310uR1LVpLY9dHtkLCnK4KRBXuwpo1SfoRI8XMlHDqHaIEddSWufblWCxwBDEJv4ZT2dtNAMsC1sZXYMgXg/q6K/jX6O7cC41w7OKyA1VWj6MXRed/clSPcNQMbMP+wKZgxE2EOoUrWxQp0h3cK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eqgRjKvx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=ejrb0r/YALyS6aGWfYb+zt6lZSFk7NAHKIFYQaIufYM=; b=eqgRjKvx/gGaahA31h7Aph+E0z
	wAzgoAcTJsddu7FX/jr2BGi7CDsiEdgBRdFBBdZ5P5kn1Agi3c+xOckoHcbdHe2qPvYLH8bn3Kq/u
	1I3BhazDCyFXzLDTZldyMMRcUWgoquLOxmSK0DEt2rTLfM6+ceXhs0FlnukLWdlqdqWQINfdGRE3J
	jcWitLLc4VUc0zz4HcV/5VyutGMDDvFBhnSl/ZqNAwcTSyNxKU7M092Jx+Iuj+7XswOma5s4Fn0dA
	9zt1Cnfy957GQIXZ2Ul7PWEhe0t/74cq5ffc99Knc0DabHfz85ZUb+V4gtynUneOf7lTKGfFQHE+r
	Q+bNUwHg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmWA-0000000FQZS-3Seo;
	Tue, 12 Aug 2025 10:46:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id B68BF302E34; Tue, 12 Aug 2025 12:46:09 +0200 (CEST)
Message-ID: <20250812104019.605285302@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 12 Aug 2025 12:39:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 torvalds@linuxfoundation.org,
 mingo@kernel.org,
 namhyung@kernel.org,
 acme@redhat.com,
 kees@kernel.org
Subject: [PATCH v3 11/15] perf: Make RB allocation branch self sufficient
References: <20250812103858.234850285@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Ensure @rb usage doesn't extend out of the branch block.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7116,8 +7116,6 @@ static int perf_mmap(struct file *file,
 				 * multiple times.
 				 */
 				ret = 0;
-				/* We need the rb to map pages. */
-				rb = event->rb;
 				perf_mmap_account(vma, user_extra, extra);
 				atomic_inc(&event->mmap_count);
 				goto unlock;
@@ -7136,8 +7134,6 @@ static int perf_mmap(struct file *file,
 			goto unlock;
 		}
 
-		WARN_ON(!rb && event->rb);
-
 		if (vma->vm_flags & VM_WRITE)
 			flags |= RING_BUFFER_WRITABLE;
 
@@ -7190,7 +7186,7 @@ static int perf_mmap(struct file *file,
 	 * full cleanup in this case and therefore does not invoke
 	 * vmops::close().
 	 */
-	ret = map_range(rb, vma);
+	ret = map_range(event->rb, vma);
 	if (ret)
 		perf_mmap_close(vma);
 



