Return-Path: <linux-kernel+bounces-766282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7087BB2449C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB257B336F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9822EA48D;
	Wed, 13 Aug 2025 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pwa6ulYr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6A2EFDB6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074693; cv=none; b=riSgMwWecPtf9ubYLhDhieobiobpRRJ96xb6YDNgxwUUy5KcpGoMk3yNZeelDOEyUhiGJ3l076srW76bMdpZovyAnnwqNQsjUO/WQy/Ou0P0X/GdAKQ+iccxMn/PU6+xsdih//OlKIghzkPeNljDlBMYgFMqv2xZGM7HlOG2TqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074693; c=relaxed/simple;
	bh=2/EAnkjXcTl6kL8hXLJfo+QTFLql8w/SHxcnf5u2FlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQNs6nanjvo5r3H7enT2i3SpbCo2HjdyLTcu4WbFX2YF7R01aka17yflpSdjnUZtvOMSD0zOyL1JDuhxipbDgECEa91nl3D8g18KWpUqmQYsU17fMkN3BYNv4Lgdejk7EXvLDdkDteW/ShRcd+V/KYlXmYxpUx8hKgVsExtqW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pwa6ulYr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7rzqs0qGkDc6v3ArlyOctsNwaIdMItx9CT994tsm9tg=; b=pwa6ulYrQ716xq20QB2rFkklws
	9HVFsbRY4pQa81+xCDo0MkM/Iy4Zbsf8pQjz5auP63IntzPC1zdN6zqaBQN9fYVJjrU6CN1tt8aF5
	ZZ4dJ/RNOSyUotvYBpePta3k6Oadny0jT9R0khHSv9OHwUCbdi+9//FyjC6nP/EYr2945RN4neatn
	2rFCFygU1r51jN6VOpVBSDenqzgI8nj+8hXrKOHTFWvSyayfHuEZJ3udPnIQ4qP1nmg8uYXrdRwsQ
	NFGtGr2jeIQ+PG9GemCVueyO72F3/G+ChxvVgAZLaexTlC+Nhxe9Min3SrKL0SzK1BHwJXPpFTfpn
	WqUIO2cw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um76F-000000079W9-4ATn;
	Wed, 13 Aug 2025 08:44:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 33B423002C5; Wed, 13 Aug 2025 10:44:48 +0200 (CEST)
Date: Wed, 13 Aug 2025 10:44:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
	torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
	acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 13/15] perf: Use scoped_guard() for mmap_mutex in
 perf_mmap()
Message-ID: <20250813084448.GB4068168@noisy.programming.kicks-ass.net>
References: <20250812103858.234850285@infradead.org>
 <20250812104019.838047976@infradead.org>
 <a9085638-b560-43a6-861e-74e52b431783@lucifer.local>
 <20250813083244.GL4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813083244.GL4067720@noisy.programming.kicks-ass.net>

On Wed, Aug 13, 2025 at 10:32:44AM +0200, Peter Zijlstra wrote:
> On Wed, Aug 13, 2025 at 07:42:41AM +0100, Lorenzo Stoakes wrote:
> 
> > > +	scoped_guard (mutex, &event->mmap_mutex) {
> > > +		/*
> > > +		 * This relies on __pmu_detach_event() taking mmap_mutex after marking
> > > +		 * the event REVOKED. Either we observe the state, or __pmu_detach_event()
> > > +		 * will detach the rb created here.
> > > +		 */
> > > +		if (event->state <= PERF_EVENT_STATE_REVOKED) {
> > > +			ret = -ENODEV;
> > > +			break;
> > 
> > I don't absolutely love this break-for-what-is-not-obviously-a-for-loop
> > formulation (I know scoped_guard in practice _is_ a for loop, but obviously
> > that's hidden by macro), but I guess hey it's C, and we have to do what we
> > have to do :)
> 
> Right, don't love it either, but the alternative was a goto and that's
> arguably worse, so meh.
> 
> > > +		}
> > >
> > > +		if (vma->vm_pgoff == 0)
> > > +			ret = perf_mmap_rb(vma, event, nr_pages);
> > > +		else
> > > +			ret = perf_mmap_aux(vma, event, nr_pages);
> > >  	}
> > >
> > >  	if (ret)
> > >  		return ret;
> > >

Nah, I'm an idiot.. How's this?

---

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 20189a3354f2..4b82f8ed6b4e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7151,20 +7151,17 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		 * the event REVOKED. Either we observe the state, or __pmu_detach_event()
 		 * will detach the rb created here.
 		 */
-		if (event->state <= PERF_EVENT_STATE_REVOKED) {
-			ret = -ENODEV;
-			break;
-		}
+		if (event->state <= PERF_EVENT_STATE_REVOKED)
+			return -ENODEV;
 
 		if (vma->vm_pgoff == 0)
 			ret = perf_mmap_rb(vma, event, nr_pages);
 		else
 			ret = perf_mmap_aux(vma, event, nr_pages);
+		if (ret)
+			return ret;
 	}
 
-	if (ret)
-		return ret;
-
 	/*
 	 * Since pinned accounting is per vm we cannot allow fork() to copy our
 	 * vma.

