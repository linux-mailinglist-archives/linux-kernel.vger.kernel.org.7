Return-Path: <linux-kernel+bounces-762591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A669CB208C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA763B7863
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C175E2D3755;
	Mon, 11 Aug 2025 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N44I/Saf"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65C126AE4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915310; cv=none; b=etOjUAKWDWd3ew/dY0MghG2EvblHOJN6Y6TFHNnbXdJzUwa+4guBzr0bxCBVPaK4Dfefugt78Wlgb+4IW4GirRXtRURAdrXydHRVWcBMSwGWcnWTSoIAcd3DCfRhMLuEAegFhXesMKBDKGpcs3PEwLcYi/zNJQdbuXXeSHIuRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915310; c=relaxed/simple;
	bh=aCVuUR5wXZ0n7ewiLDmiuAP6HDwwg+BznHR2eV1sIkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPLjRJH8V/3u430y0JOgHgGzEUG13tdp49aLHd9dMmOFF6cUHyg1oT31aRW9mI+3TReOn+etistumogYZOClVpllb6F1PQNjEbfMxDS3lBzjTn2DKGDO+AhtQmS3H/+ulQ3dNCCyDoy14lcDGwvFmeK3mhoFhIe3D0Sd9IHPwyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N44I/Saf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=83rd1xnBS14APjqGFTUVJoyb3lrI2gdYoVcvWG2ZOvY=; b=N44I/SafpUO+cNPT39ieeEAeFf
	E5WvliQy3AgorOZydb3qkjLn3uPy3O3pRVbd7hDoB29POEaJlIqQY+KU+8aENUIX3X0iTUzdllbOI
	sxzvRkmKyp9Ohe9oKIBoNntsSq9BGNVltk/PauYcH43CiTsg+A/TDREVmgQ4hZpw3L3wK7w4tH4+b
	STuGRHGsXWINXGGxcu0WNdqBsA8MDkqzviMiB0qalMhk5cUZDgmA5J3gZ7qbna6MQaw06aGuQvdfK
	4yesif9lD6HhQREkwDJsbSSXKaWYsJk1HihpuXdGzUtCrnWCn1RexMO/CqV+W+MD3JtG+V43uqN0+
	S2eJjXow==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulRdX-00000005PmI-3lWj;
	Mon, 11 Aug 2025 12:28:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 19199300310; Mon, 11 Aug 2025 14:28:24 +0200 (CEST)
Date: Mon, 11 Aug 2025 14:28:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 m@/6] perf/core: Split out AUX buffer allocation
Message-ID: <20250811122824.GA3940894@noisy.programming.kicks-ass.net>
References: <20250811065859.660930338@linutronix.de>
 <20250811070620.590421133@linutronix.de>
 <20250811100403.GE1613200@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811100403.GE1613200@noisy.programming.kicks-ass.net>

On Mon, Aug 11, 2025 at 12:04:04PM +0200, Peter Zijlstra wrote:

> These two aux and rb split out patches seem like they're trying to take
> too big a step. Let me try and do the same with smaller steps.

Find here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core

Now, I need a food :-)

