Return-Path: <linux-kernel+bounces-831910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B002B9DDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467901B286E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678942E8E11;
	Thu, 25 Sep 2025 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aD+eHFcG"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7029A2E7BAE;
	Thu, 25 Sep 2025 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785382; cv=none; b=IJLNQ+Ywc2xUsLGws+wVOqjiFWANBmkSF1WBWSiaD9Mrl74dh6TKcEXkCj1lILdi3shhmRmJlgfSO0WQrsG3C6J8Qi0eyXei5ed2VcdV0ks5tMW11KVMFUQqWAD8+MVSlKxFxMVWUHlufp+n1J2EyonpVJXsn9FhFmyDr307VZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785382; c=relaxed/simple;
	bh=7NLOVI28JwOsTEmS8wXWlHMjYNnFy7QTN9tD3mKyRu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXH0U6sPWtWuXhkhQDXZxRbUmBv4pNe8qOwo5rSKgVe9/iEIlhFFckunaRP81rLkC4ma3iyaMmww4vF1IVtUdWvO9Wk0CA/8HKeRBd7WIFeJtsHTkXzhXGLJnouIuckd8Hwo96xip8VJux/fagBQhgY2btE6s+u3mlNapArU6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aD+eHFcG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jvhf3J+H3AMtqjjQxZ6iJAkHwORDWBYzJvjGTYfbPAc=; b=aD+eHFcGcZskqPVnBWbmSCq0XD
	ztzJGLVORE1D8WRP62d2IlGPBxtYTcQnKX+y3Ez/ZkCPqPaDwLT2MSosWNWmYpR1VVeqVhLdATbvo
	gbo7MXxby3vXstixZgTz+kT4uLf5Bdzpmnplecw48pglSMeVjRDCYSjBCS21ik+6gOSVUQ5JBwx9+
	1pG6tPcJIIdz2/M7vYkz4HSmBbghY43i5cBU1l07vm8vak/jMIDcVFwlynjHDstadd5fCqcce/jnY
	su0Ionxl5ndy4YMaPSVENlXtEf5oM+UWAUXgb8SWMLTyCZDmI5pZHG/SQ0ude4o8V5yae6Fmg6GAc
	omNHe3PA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1gQ3-0000000BhnJ-440o;
	Thu, 25 Sep 2025 07:29:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8A2E730023C; Thu, 25 Sep 2025 09:29:35 +0200 (CEST)
Date: Thu, 25 Sep 2025 09:29:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Fernand Sieber <sieberf@amazon.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [tip:sched/urgent] [sched/fair]  78f8764d34:
 Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN_PTI
Message-ID: <20250925072935.GV4067720@noisy.programming.kicks-ass.net>
References: <202509251504.1f53d5d1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509251504.1f53d5d1-lkp@intel.com>

On Thu, Sep 25, 2025 at 03:26:41PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN_PTI" on:
> 
> commit: 78f8764d34c0a1912ce209bb2a428a94d062707f ("sched/fair: Forfeit vruntime on yield()")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/urgent

I suppose I'll just zap this patch -- there is a new version of it
anyway.

