Return-Path: <linux-kernel+bounces-886337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8051EC354AB
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A0362275F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9475730F546;
	Wed,  5 Nov 2025 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iCKKnfn7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1153E30EF89;
	Wed,  5 Nov 2025 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762340437; cv=none; b=E/yEZJZ7mVQgZCaOomieixUoXkDK78rXDNk8C2IA6h43AR4xFGp2rBItvPj+puSYGjYCE6qf4HRmFgA9YiqZJWShq4d5Ux3S0LtUI5YoFDDtJwGUK+AQmcZf3LxkFaNq7aJlAcwbiKznFdFO/k10wGrDLLT0DnnQkMWr6E5Tjfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762340437; c=relaxed/simple;
	bh=0frN4Ydex62MR9blW5nQL3JIscHl7H6SztNBiRDUr9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBZJ1/bQ8/xHQYegmk4prJPgt9yPF8SjVKu30/YsiE4Il+Z101yU+R506mZHzXLoY8O120FI/3aU0iHxnGryik8hdaiUlk6FZfxvQpy+GI8HCFjXSwkl9qoBF+gQUohyMgH6MttP3d+9pj3w//0y8nGxLJCv0UZrnEZT07FNJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iCKKnfn7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r4dNssuBIX3kLf4QLulycGpF4N2z+mVGDeDOZbf0Sz4=; b=iCKKnfn7I2hblI+EDuOylvkM43
	LWVWUtBVQ92Y+eg3+G2VO0cBfRv2Dl3ir418Qi8U2HDUgURG7fhtNKlqn+x0HbKL7J/xExY+IonBV
	R3wIxt3ILBNzHhSbJFWh9pXPLOOzSa56NwNX5SKILtXpijKahN5GOO+A11i8YpDKnOZs93dOc6Y0C
	NGwhl3ykyU5BLFaVf/4gcVDYes6Olwhn6c5baQovL6oFH6pDn/cD+PNr8aYkhI6RZ/xWF4f5ZD98Q
	MjR+lUS3u6oitkDAl9nJOCZE1Kdt+lzQN2+x8LTVA1KM1AoCb+QwMTbAFpw0jD2NBAId7BGBm2FJE
	rZvGz0Sw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGbFb-00000003i8h-0Lnl;
	Wed, 05 Nov 2025 11:00:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ED3FE300230; Wed, 05 Nov 2025 12:00:26 +0100 (CET)
Date: Wed, 5 Nov 2025 12:00:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Fernand Sieber <sieberf@amazon.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	aubrey.li@linux.intel.com
Subject: Re: [tip:sched/core] [sched/fair] 79104becf4:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20251105110026.GI988547@noisy.programming.kicks-ass.net>
References: <202510211205.1e0f5223-lkp@intel.com>
 <20251021110449.GO3245006@noisy.programming.kicks-ass.net>
 <20251027125453.GY4067720@noisy.programming.kicks-ass.net>
 <3b30e40b-f1fb-4145-b4d9-a9279b9602d8@intel.com>
 <20251027135516.GA3419281@noisy.programming.kicks-ass.net>
 <20251027140718.GT1386988@noisy.programming.kicks-ass.net>
 <20251027140959.GU1386988@noisy.programming.kicks-ass.net>
 <e9f705f3-3a8f-4952-b5d5-e36f4fa1515d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9f705f3-3a8f-4952-b5d5-e36f4fa1515d@intel.com>

On Tue, Oct 28, 2025 at 10:30:08AM +0800, Chen, Yu C wrote:
> On 10/27/2025 10:09 PM, Peter Zijlstra wrote:
> > On Mon, Oct 27, 2025 at 03:07:18PM +0100, Peter Zijlstra wrote:
> > > On Mon, Oct 27, 2025 at 02:55:16PM +0100, Peter Zijlstra wrote:
> > > 
> > > > > May I know if you are using the kernel config 0day attached?
> > > > > I found that the config 0day attached
> > > > > (https://download.01.org/0day-ci/archive/20251021/202510211205.1e0f5223-lkp@intel.com/config-6.18.0-rc1-00001-g79104becf42b)
> > > > > has
> > > > > CONFIG_IA32_EMULATION=y
> > > > > CONFIG_IA32_EMULATION_DEFAULT_DISABLED=y
> > > 
> > > Yep, deleting that entry makes it all work.
> > 
> > 'work' might be over stating, it boots and starts trinity, which then
> > promptly (as in a handful of seconds) triggers OOM and dies. Not
> > actually reproducing the NULL deref I was looking for.
> 
> Change the following line in job-script
> export memory='16G'
> to
> export memory='64G'
> ?

Yes, that seems to help.

> I had a try and can reproduce the NULL except at first run:

Took me two runs, but yes, I can see it now.

Anyway, this is two bugs in the robot, can we please fix all this to not
happen again?

 - .config has 32bit disabled while robot provides 32bit images. Clearly
   the actual robot runs 64bit images and the reproduction should
   provide those too.

 - job description is inaccurate in the amount of memory required.

The reproduction steps must exactly match what the real robot runs, not
something else.

