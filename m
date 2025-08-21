Return-Path: <linux-kernel+bounces-779437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2656FB2F41B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4041FAA1977
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED6D2E0936;
	Thu, 21 Aug 2025 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V/cwumds"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD77B1C69D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769013; cv=none; b=eh+jUN7M/SYQk6mbn2V1kNDmaMfeJbuez2eu7xNQKLEJfe+9j6FAm/hYp2ppje4tZs/peDTSY5Dx19IRT+Tz7WaybYH2eNFvpeXj7PV/Gf14kgKBOchX2L6TNuSOzebYbsi6O3AH2zGvLH3GYH2q/toSf0Pr02N46TeO3Ta4SG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769013; c=relaxed/simple;
	bh=W54AzuSoSfPrcN8CNfcLa9sN+8OE8+9joaZTfuSfklY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgjUjXo6QEQEznM0HoJUxPB0Asq0sOA2sJ5KG8Tw0obxGvUYXQc7cVAyPL13hFn+GCfa2ZQBt8LuQSPsAlhpIIgzuZeamp4iYEuaZ2pIWUSrLE4hme4Ki/rgVam1RSGLj3J8x3qaIIs9x2pSHJC5wrjuB3VaZHbLHobMqZHPg84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V/cwumds; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W54AzuSoSfPrcN8CNfcLa9sN+8OE8+9joaZTfuSfklY=; b=V/cwumdsjafMPZY7iwswe9WTFH
	kavvdmSgrdo4AfioP83OxDtA/Lqexv0cKF1ZkCVywHcrZ+jQ3GVhu0Lk5XXOP7V62PrRuEAARfTqg
	wCKNNkLxXb+o6TwpYFz4wWT7CYinYFl5277WmskGVo4bzBOYOsMDMunAWYaHjGeuTGL1saOtrMS3W
	M5dwqCib1PIboOfMs/4PRLPqDVSwJ5JD2vUWre26eLhUeUucOPwkxaDiX+CN1ym7gJ/mEkhWpeYdC
	wjZgtM/lagk8wRBv2p4a9ecFQxdDYsuM1NVRsgRwygfM1LaGwAjAsS+nu+pu2vB05AfvNk8foirIj
	M/HPgmRA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up1iy-00000000VrF-0T8d;
	Thu, 21 Aug 2025 09:36:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5DA1F302E5F; Thu, 21 Aug 2025 11:36:47 +0200 (CEST)
Date: Thu, 21 Aug 2025 11:36:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [GIT pull] sched/urgent for v6.16-rc7
Message-ID: <20250821093647.GN3245006@noisy.programming.kicks-ass.net>
References: <175301303546.263023.1426155806374119244.tglx@xen13>
 <175301303716.263023.8607719725649129120.tglx@xen13>
 <CAHk-=wiMNdBYJcDo47riSP5=_Re4A-itmBwBfsnDxZqvfn5tHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiMNdBYJcDo47riSP5=_Re4A-itmBwBfsnDxZqvfn5tHQ@mail.gmail.com>

On Sun, Jul 20, 2025 at 11:20:31AM -0700, Linus Torvalds wrote:

> I've obviously pulled this, but considering that the thing isn't
> actually really an unsigned value in the first place, and all users
> seem to cast it to 'long' anyway, there's an obvious question... Why
> is it unsigned in the first place, rather than just make it be the
> more natural signed type?

Histerical raisins AFAIU. I think the original reason to make the thing
unsigned was to get the 2s complement wrapping behaviour.

Yes, these days we have -fwrapv and everybody knows signed types wrap
properly too (although Kees will argue signed should not wrap etc..).
But back then who knows.


