Return-Path: <linux-kernel+bounces-794246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAE0B3DEE9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B8B16528C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56F830ACE0;
	Mon,  1 Sep 2025 09:43:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EC62EE268;
	Mon,  1 Sep 2025 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719828; cv=none; b=ERmJKmEnXqdY5V596EBk2sJ8cytXEctzOY2U9ERp+XrTtnVdSjqXd7W3hm2uVQeqegiBkGNzhOceIcF5/pbwNyo1YVhcFewyJ6myKP0Kd7OaMY+b0oY12O6hxs1UhACRqavxA9GCv8lqw70VSlNr4TqRv3WEabqMLuPN9eCTvhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719828; c=relaxed/simple;
	bh=GB9NS4DxV4hbc7q7DXgaHB6wXEnJNDBA09Hk3YN6arg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bApAJPobwir5qJPpdm71AQmB4xN3qsz+RD6t4M6gi+tILK/wuRxdyfNG8LDmp3m39PMls1XKME2y4RsFBEDwK1NQ0V/T0hfC2UxF/bRhmqcFYuUIRCfP36Eo/6ajUFxlbJ73s8tMcSc/Q56KNq4Kf+XUHR4qNxACtxa3GU3SMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 793791A25;
	Mon,  1 Sep 2025 02:43:37 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7F953F694;
	Mon,  1 Sep 2025 02:43:43 -0700 (PDT)
Date: Mon, 1 Sep 2025 10:43:36 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Luo Gengkun <luogengkun@huaweicloud.com>, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracing: Fix tracing_marker may trigger page fault
 during preempt_disable
Message-ID: <aLVqyEGoHKVCFGFR@J2N7QTR9R3>
References: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
 <20250819135008.5f1ba00e@gandalf.local.home>
 <436e4fa7-f8c7-4c23-a28a-4e5eebe2f854@huaweicloud.com>
 <20250829082604.1e3fd06e@gandalf.local.home>
 <20250829083655.3d38d02b@gandalf.local.home>
 <aLIFRHcsEo2e2GE7@arm.com>
 <20250829181311.079f33bf@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829181311.079f33bf@gandalf.local.home>

On Fri, Aug 29, 2025 at 06:13:11PM -0400, Steven Rostedt wrote:
> On Fri, 29 Aug 2025 20:53:40 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> valid user address.
> > 
> > BTW, arm64 also bails out early in do_page_fault() if in_atomic() but I
> > suspect that's not the case here.
> > 
> > Adding Al Viro since since he wrote a large part of uaccess.h.
> > 
> 
> So, __copy_from_user_inatomic() is supposed to be called if
> pagefault_disable() has already been called? If this is the case, can we
> add more comments to this code?

Just to check, you're asking for better comments in <linux/uaccess.h>,
right?

> I've been using the inatomic() version this
> way in preempt disabled locations since 2016.
> 
> Looks like it needs to be converted to copy_from_user_nofault().
> 
> Luo, this version of the patch looks legit, no need for a v2.
> 
> I just wanted to figure out why __copy_from_user_inatomic() wasn't atomic.
> If anything, it needs to be better documented.

If that had roughly the same kerneldoc comment as for
__copy_to_user_inatomic(), would that be sufficient, or do you think
both need to be made more explicit?

Mark.

